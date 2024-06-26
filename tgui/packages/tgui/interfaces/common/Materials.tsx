import { BooleanLike } from 'common/react';
import { classes } from 'common/react';

import { useSharedState } from '../../backend';
import { Box, Button, Flex, NumberInput } from '../../components';
import { BoxProps } from '../../components/Box';
import { formatMoney, formatSiUnit } from '../../format';

export const MATERIAL_KEYS = {
  "iron": "sheet-metal_3",
  "glass": "sheet-glass_3",
  "silver": "sheet-silver_3",
  "gold": "sheet-gold_3",
  "diamond": "sheet-diamond",
  "plasma": "sheet-plasma_3",
  "uranium": "sheet-uranium",
  "bananium": "sheet-bananium",
  "titanium": "sheet-titanium_3",
  "bluespace crystal": "polycrystal",
  "plastic": "sheet-plastic_3",
} as const;

export type Material = {
  name: keyof typeof MATERIAL_KEYS;
  ref: string;
  amount: number;
  sheets: number;
  removable: BooleanLike;
};

interface MaterialIconProps extends BoxProps {
  readonly material: keyof typeof MATERIAL_KEYS;
}

export const MaterialIcon = (props: MaterialIconProps) => {
  const { material, ...rest } = props;

  return (<Box
    {...rest}
    className={classes([
      'sheetmaterials32x32',
      MATERIAL_KEYS[material],
    ])} />);
};

const EjectMaterial = (props: {
  readonly material: Material,
  readonly onEject: (amount: number) => void,
}, context) => {
  const {
    name,
    removable,
    sheets,
  } = props.material;
  const [removeMaterials, setRemoveMaterials] = useSharedState(
    context, 'remove_mats_' + name, 1);
  if (removeMaterials > 1 && sheets < removeMaterials) {
    setRemoveMaterials(sheets || 1);
  }
  return (
    <>
      <NumberInput
        width="30px"
        animated
        value={removeMaterials}
        minValue={1}
        maxValue={sheets || 1}
        initial={1}
        onDrag={(e, val) => {
          const newVal = parseInt(val, 10);
          if (Number.isInteger(newVal)) {
            setRemoveMaterials(newVal);
          }
        }} />
      <Button
        icon="eject"
        disabled={!removable}
        onClick={() => {
          props.onEject(removeMaterials);
        }} />
    </>
  );
};

export const Materials = (props: {
  readonly materials: Material[],
  readonly onEject: (ref: string, amount: number) => void,
}) => {
  return (
    <Flex wrap>
      {props.materials.map(material => (
        <Flex.Item key={material.name} grow={1} shrink={1}>
          <MaterialAmount
            name={material.name}
            amount={material.amount}
            formatting={MaterialFormatting.SIUnits} />
          <Box mt={1} textAlign="center">
            <EjectMaterial material={material} onEject={(amount) => {
              props.onEject(material.ref, amount);
            }} />
          </Box>
        </Flex.Item>
      ))}
    </Flex>
  );
};

export enum MaterialFormatting {
  SIUnits,
  Money,
  Locale,
}

export const MaterialAmount = (props: {
  readonly name: keyof typeof MATERIAL_KEYS,
  readonly amount: number,
  readonly formatting?: MaterialFormatting,
  readonly color?: string,
  readonly style?: Record<string, string>,
}) => {
  const {
    name,
    amount,
    color,
    style,
  } = props;

  let amountDisplay;

  switch (props.formatting) {
    case MaterialFormatting.SIUnits:
      amountDisplay = formatSiUnit(amount, 0);
      break;
    case MaterialFormatting.Money:
      amountDisplay = formatMoney(amount);
      break;
    case MaterialFormatting.Locale:
      amountDisplay = amount.toLocaleString();
      break;
    default:
      amountDisplay = amount;
  }

  return (
    <Flex direction="column" textAlign="center">
      <Flex.Item>
        <MaterialIcon material={name} style={style} />
      </Flex.Item>
      <Flex.Item color={color}>
        {amountDisplay}
      </Flex.Item>
    </Flex>
  );
};
