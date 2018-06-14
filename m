Received: from eggs.gnu.org ([2001:4830:134:3::10]:56862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fTUhm-0002oe-8c
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fTUhg-0001aj-F1
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:02:34 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fTUhg-0001a8-7J
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:02:28 -0400
Received: by mail-wm0-x229.google.com with SMTP id 69-v6so12973272wmf.3
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 09:02:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zhzxzrsc.fsf@linaro.org>
References: <20180614081610.12092-1-stefanha@redhat.com>
	<87zhzxzrsc.fsf@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 14 Jun 2018 17:02:26 +0100
Message-ID: <CAJSP0QVp+fdfSz0fiuNCgYHey-=jd+4OsmrLqLVJxEwYs6Yfyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2] target/arm: add ARMv6-M UNDEFINED 32-bit
 instruction test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <qemu.ml@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

On Thu, Jun 14, 2018 at 9:38 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> I'm hoping to have my TCG testing merged before this but it would clash:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02002.html
>
> Any chance you could re-base on that tree and use the cross-compiler
> infrastructure it provides?
>
> I don't see a problem shipping the hex files for those that don't have
> docker/cross-compiler setups though.

Sure.  I will send a v3.

Stefan
