Received: from eggs.gnu.org ([2001:4830:134:3::10]:57461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbo7u-0007Dg-ED
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbo7q-0005fY-4K
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:47:06 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbo7p-0005fR-Sn
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:47:02 -0500
Received: by mail-wr0-x232.google.com with SMTP id 89so82979184wrr.2
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 04:47:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWGcG9bTZZr22BEj-P_G2r4UhmNwGSfwSnwjZeTC687GQ@mail.gmail.com>
References: <CAJSP0QWGcG9bTZZr22BEj-P_G2r4UhmNwGSfwSnwjZeTC687GQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Feb 2017 12:46:40 +0000
Message-ID: <CAFEAcA_OJWrknC+YSsbjgcv=YtMq5GY04EcyXZt+V8eBH5TSWw@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 18 January 2017 at 10:52, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> QEMU will be applying to Google Summer of Code again this year.
>
> Do you want to help some of the most talented university students
> begin contributing to open source by working on our codebase and
> joining our community?
>
> We need to put together a list of project ideas by February 9:
> http://qemu-project.org/Google_Summer_of_Code_2017#Project_Ideas

Slightly late, but I had an idea last night: would "get
Raspbian booting on our raspi2 board model" be a good
project? Would involve some mix of bug fixing, cleaning
up and adding device models from the raspi2 tree on github,
and implementing missing devices. Bit of a "how long is a
piece of string" project, but on the other hand breaks
down easily into small parts that can all go upstream
individually. Would suit student who likes debugging :-)

thanks
-- PMM
