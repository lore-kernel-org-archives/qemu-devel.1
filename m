Received: from eggs.gnu.org ([209.51.188.92]:36326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzV6G-0005KV-Ef
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 18:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gzV6F-0004Qg-IG
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 18:28:24 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:38712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gzV6F-0004Pi-BD
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 18:28:23 -0500
Received: by mail-wr1-f43.google.com with SMTP id g12so11806622wrm.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 15:28:23 -0800 (PST)
References: <20190228202537.4638-1-alex.bennee@linaro.org>
	<20190228202537.4638-8-alex.bennee@linaro.org>
	<71a55c0c-3c09-edea-82a5-63fb0cfb4f12@redhat.com>
	<CAMo8BfKvQZyp3ri356LoqCDhsFszU5proLGH2MBbBi2pgRZ4rw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a845da4a-603f-a469-77a8-028c5a5d2063@redhat.com>
Date: Fri, 1 Mar 2019 00:28:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAMo8BfKvQZyp3ri356LoqCDhsFszU5proLGH2MBbBi2pgRZ4rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/16] tests/tcg/xtensa: enable system
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On 3/1/19 12:24 AM, Max Filippov wrote:
> On Thu, Feb 28, 2019 at 2:54 PM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
> 
>> BTW is this simulator downloadable? I see the Zephyr project also uses
>> it, and I looked for it on https://ip.cadence.com/swdev but couldnt find
>> a (public) link.
> 
> There's a site https://www.tensilicatools.com/
> with tools for various end-user-programmable xtensa cores,
> but I'm pretty sure that neither dc232b nor dc233c are available
> there.

Thanks!

Phil.
