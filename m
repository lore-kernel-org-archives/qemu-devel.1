Received: from eggs.gnu.org ([2001:4830:134:3::10]:39785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTmTo-00078o-0S
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTmTi-0002Iz-HO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:01:20 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTmTi-0002IL-0M
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:01:14 -0400
Received: by mail-oi0-x242.google.com with SMTP id d5-v6so8439899oib.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 04:01:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606154835.2276-1-f4bug@amsat.org>
References: <20180606154835.2276-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 12:00:52 +0100
Message-ID: <CAFEAcA8-tJstsVBsi8OEo-wZELV+yLnqRpCZ_EMpXp2+LK7M2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v3 0/1] SDCard: support UHS-I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2018 at 16:48, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Hi Peter,
>
> This is a rewrite of the previous series after running tests and sniffed
> traffic on real hardware.
> Tagged RFC to be sure this particular patch is going in the correct
> direction, before reposting the series with the 'uhs' property patches.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(Haven't applied it since you tagged it RFC; let me know if you
want me to.)

thanks
-- PMM
