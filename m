Received: from eggs.gnu.org ([2001:4830:134:3::10]:50373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYZwK-0004gh-Bl
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYZwG-00078s-Gs
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:06:20 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:33579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYZwG-00077Y-BI
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:06:16 -0500
Received: by mail-oi0-x236.google.com with SMTP id y141so1282467oia.0
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 08:06:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <23123.38373.555937.75671@guava.gson.org>
References: <23118.26328.811644.330716@guava.gson.org>
	<CAFEAcA_iPT14HSkMG4T43H3vykqBu=rFJpBe4idoVh9LFUEJaA@mail.gmail.com>
	<23123.38373.555937.75671@guava.gson.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 16:05:55 +0000
Message-ID: <CAFEAcA8E9DxY7AA7fvFze5HFD_aQPn0T4Cn1u+C40Tqs7qefSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: check for posix_memalign in
 configure script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Gustafsson <gson@gson.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 8 January 2018 at 16:01, Andreas Gustafsson <gson@gson.org> wrote:
> Peter Maydell wrote:
>> Can we put this through the -trivial tree? (cc'd)
>
> I'm not sufficiently familiar with the intenal workflows of the qemu
> project to give a meaningful answer to that question.

Sorry, I should have been clearer, that question was aimed
at the qemu-trivial queue maintainers.

thanks
-- PMM
