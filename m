Received: from eggs.gnu.org ([2001:4830:134:3::10]:34195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNiNB-0003M3-SC
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNiNB-0002OP-9x
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:20:53 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNiNB-0002Nt-2J
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:20:53 -0400
Received: by mail-wr0-x22d.google.com with SMTP id r103so141577638wrb.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:20:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f2644920-8eda-e768-adee-71db36ea2fa3@amsat.org>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
	<BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
	<20170508225007.2duqxlo5ab2aenpl@aurel32.net>
	<alpine.BSF.2.20.1705091148560.78100@zero.eik.bme.hu>
	<F3D7AC88-099F-432D-B46F-97F2A6F7B0E3@gmail.com>
	<f2644920-8eda-e768-adee-71db36ea2fa3@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jun 2017 17:20:31 +0100
Message-ID: <CAFEAcA-72bvtKsPHttUizYj8EvZJDfjUda7CeZe-tpRk73+NXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: G 3 <programmingkidx@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 21 June 2017 at 17:14, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> do you think you can add your test as a qtest, to run it with check-qtest=
?

We don't yet have any mechanism for having tests that need to
be compiled for the target architecture, do we?

thanks
-- PMM
