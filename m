Received: from eggs.gnu.org ([2001:4830:134:3::10]:52360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYnN-0000c6-6V
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxYnM-0001lg-5b
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:51:49 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxYnL-0001lW-VP
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 08:51:48 -0400
Received: by mail-wr0-x22a.google.com with SMTP id o21so119783124wrb.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 05:51:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170410102254.GA20072@stefanha-x1.localdomain>
References: <1491629987-6826-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170410102254.GA20072@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 13:51:26 +0100
Message-ID: <CAFEAcA8DjtpNiuiEvZ7=rX6cTq0Dn6wj=ud8Bkted+W5+COc1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Removed trailing newline from
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 10 April 2017 at 11:22, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Sat, Apr 08, 2017 at 11:09:47AM +0530, Ishani Chugh wrote:
>> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
>> ---
>>  target/arm/kvm64.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks for the patch!
>
> I have CCed Peter Maydell who maintains this source file.  I also added
> the trivial patches mailing list - a patch queue for small patches.

I've applied this patch to my target-arm queue (with commit message
tweak as Stefan suggests) -- thanks!

-- PMM
