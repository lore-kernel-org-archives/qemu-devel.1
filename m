Received: from eggs.gnu.org ([2001:4830:134:3::10]:59919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eECy4-0004ZJ-Ls
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eECy3-0000bT-Jg
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:31:56 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eECy3-0000bB-Di
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:31:55 -0500
Received: by mail-wr0-x241.google.com with SMTP id y9so14134315wrb.2
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 03:31:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510552520-3566-1-git-send-email-sundeep.lkml@gmail.com>
References: <1510552520-3566-1-git-send-email-sundeep.lkml@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 11:31:33 +0000
Message-ID: <CAFEAcA8TUn6e-bdcDXnUuLpQm5PWBtOqN1pJbxZPO5BJ-rdABA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu devel PATCH v2] MAINTAINERS: Add entries for
 Smartfusion2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair23@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 13 November 2017 at 05:55, Subbaraya Sundeep <sundeep.lkml@gmail.com> wr=
ote:
> Voluntarily add myself as maintainer for Smartfusion2
>
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2:
>         reframed commit message as per Alistair's comment.
>         Renamed MSF2 SoC -> SmartFusion2
>                         MSF2 SOM -> Emcraft M2S-FG484
>                 as per Philippe's comments.



Applied to target-arm.next, thanks.

-- PMM
