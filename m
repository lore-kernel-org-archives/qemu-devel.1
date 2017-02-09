Received: from eggs.gnu.org ([2001:4830:134:3::10]:35568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbwmv-0005hR-Ca
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbwmu-0005gn-Kh
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:02:01 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbwmu-0005gi-Fc
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 17:02:00 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v186so94366536wmd.0
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 14:02:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e5673883-cd68-7d4a-01fc-394c506b18a9@redhat.com>
References: <CAJSP0QWGcG9bTZZr22BEj-P_G2r4UhmNwGSfwSnwjZeTC687GQ@mail.gmail.com>
	<CAFEAcA_OJWrknC+YSsbjgcv=YtMq5GY04EcyXZt+V8eBH5TSWw@mail.gmail.com>
	<e5673883-cd68-7d4a-01fc-394c506b18a9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Feb 2017 22:01:38 +0000
Message-ID: <CAFEAcA8zSZ8S09APwV8SGy3oHeiutY1j+LSSP327hyZLFfDURw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Call for GSoC 2017 mentors & project ideas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On 9 February 2017 at 20:46, John Snow <jsnow@redhat.com> wrote:
> On 02/09/2017 07:46 AM, Peter Maydell wrote:
>> Slightly late, but I had an idea last night: would "get
>> Raspbian booting on our raspi2 board model" be a good
>> project? Would involve some mix of bug fixing, cleaning
>> up and adding device models from the raspi2 tree on github,
>> and implementing missing devices. Bit of a "how long is a
>> piece of string" project, but on the other hand breaks
>> down easily into small parts that can all go upstream
>> individually. Would suit student who likes debugging :-)

> Who was working on this most recently? There was someone submitting
> patches pretty frequently for the raspi2 board within the last year,
> wasn't there?

That was Andrew Baumann, but I think his use case was
getting Windows 10 to boot on it, which exercises
different bits of the hardware.

thanks
-- PMM
