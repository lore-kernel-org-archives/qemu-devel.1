Received: from eggs.gnu.org ([2001:4830:134:3::10]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1e9B8T-00064n-Hb
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1e9B8Q-0003Zl-9C
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:33:53 -0400
Received: from 5pmail.ess.barracuda.com ([64.235.150.217]:38519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1e9B8Q-0003Z4-3G
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:33:50 -0400
References: <1508769996-5747-1-git-send-email-yongbok.kim@imgtec.com>
	<f244049d-c103-e657-dfec-95507ffc7b3e@mips.com>
	<CAFEAcA_5j+xUrkBUCDG18o760EJxzwncCR5UjHX+S3oM3K3Xzg@mail.gmail.com>
From: Yongbok Kim <yongbok.kim@mips.com>
Message-ID: <8af6d493-3020-ebed-4ec8-b402594cddf2@mips.com>
Date: Mon, 30 Oct 2017 14:25:11 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_5j+xUrkBUCDG18o760EJxzwncCR5UjHX+S3oM3K3Xzg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PULL 0/3] MIPS queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 30/10/2017 14:20, Peter Maydell wrote:
> On 30 October 2017 at 14:09, Yongbok Kim <yongbok.kim@mips.com> wrote:
>> On 23/10/2017 15:46, Yongbok Kim wrote:
>>> The following changes since commit
>>> e822e81e350825dd94f41ee2538ff1432b812eb9:
>>>
>>>     Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'
>>> into staging (2017-10-20 15:04:00 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>     git://github.com/yongbok/upstream-qemu.git target-mips.next
>>>
>>> ----------------------------------------------------------------
>>> MIPS patches 2017-10-23
>>>
>>> Changes:
>>> Update email addresses of Yongbok Kim, James Hogan and Paul Burton.
>>>
>>> ----------------------------------------------------------------
>>>
>>> James Hogan (1):
>>>     MAINTAINERS: Update James Hogan's email address
>>>
>>> Paul Burton (1):
>>>     MAINTAINERS: Update Paul Burton's email address
>>>
>>> Yongbok Kim (1):
>>>     MAINTAINERS: Update Yongbok Kim's email address
>>>
>>>    .mailmap    |    3 +++
>>>    MAINTAINERS |   10 +++++-----
>>>    2 files changed, 8 insertions(+), 5 deletions(-)
>>>
>>>
>> Ping?
> I only notice pull requests if they contain the magic words
> "for you to fetch changes up to", which yours does not.
> 'git request-pull' includes this in its output, so you should
> probably make sure your workflow is using that.
>
> I tried applying this, but git complains:
> error: remotes/yongbok/target-mips.next: cannot verify a non-tag
> object of type commit.
>
> Pull requests should quote a gpg-signed tag name, not a branch.
>
> thanks
> -- PMM
Hm. Odd. Something went wrong then.
Ok. I will try to create a new pull-req.

Thanks,
Yongbok
