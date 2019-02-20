Received: from eggs.gnu.org ([209.51.188.92]:60755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwU8K-0004jD-Np
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwU8J-0005jF-Pr
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:50:04 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwU8J-0005dy-Ge
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:50:03 -0500
Received: by mail-ot1-x32d.google.com with SMTP id v20so8928195otk.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
	<CAFEAcA9ZhMtkh+2CXYjsbYhj69iGgQzBwT2TFOriPgvDbOaPpw@mail.gmail.com>
	<20190220164312.574d48d6@bahia.lan>
In-Reply-To: <20190220164312.574d48d6@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Feb 2019 15:49:41 +0000
Message-ID: <CAFEAcA9ZTpFCE_KHR=8AT_BJNHLNyLyVmRyjNoJOY4w5Lw2Jyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/43] ppc-for-4.0 queue 20190219
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 20 Feb 2019 at 15:43, Greg Kurz <groug@kaod.org> wrote:
> I have an account. I'll start updating the wiki according to what was
> actually merged up to this pull request.

Thanks. Personally I've found for the arm parts of the changelog
that it's much easier to update the changelog with every
pull request, and it's going to result in a more detailed log
as a result.

-- PMM
