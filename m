Received: from eggs.gnu.org ([2001:4830:134:3::10]:38048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vskytta@gmail.com>) id 1fSTNa-0000cV-I5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vskytta@gmail.com>) id 1fSTNZ-0002Fr-Dd
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:25:30 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:42916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vskytta@gmail.com>) id 1fSTNZ-0002Fh-6z
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:25:29 -0400
Received: by mail-io0-x244.google.com with SMTP id r24-v6so25416911ioh.9
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 13:25:29 -0700 (PDT)
MIME-Version: 1.0
Sender: vskytta@gmail.com
In-Reply-To: <CAFEAcA-wru_Sb8nd6+10yZUdOS-g5Mz+mEDTbWS44zFa0NS5dw@mail.gmail.com>
References: <20180611142528.11730-1-ville.skytta@iki.fi>
	<CAFEAcA-wru_Sb8nd6+10yZUdOS-g5Mz+mEDTbWS44zFa0NS5dw@mail.gmail.com>
From: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Date: Mon, 11 Jun 2018 23:25:08 +0300
Message-ID: <CABr9L5DTh=X7K7PLoH_D1RhPrfvPDE417YeYV_gfsPtU-GAvDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Grammar and spelling fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jun 11, 2018 at 6:23 PM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 11 June 2018 at 15:25, Ville Skytt=C3=A4 <ville.skytta@iki.fi> wrote:
>> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
>
>> diff --git a/docs/specs/acpi_nvdimm.txt b/docs/specs/acpi_nvdimm.txt
>> index 3f322e6f55..4da2d44534 100644
>> --- a/docs/specs/acpi_nvdimm.txt
>> +++ b/docs/specs/acpi_nvdimm.txt
>> @@ -72,7 +72,7 @@ for NVDIMM ACPI.
>>
>>  Memory:
>>     QEMU uses BIOS Linker/loader feature to ask BIOS to allocate a memor=
y
>> -   page and dynamically patch its into a int32 object named "MEMA" in A=
CPI.
>> +   page and dynamically patch its into an int32 object named "MEMA" in =
ACPI.
>
> Should this read "its address" ?

Maybe. Or just "it"? Took your suggestion, will send a new patch with
it included.
