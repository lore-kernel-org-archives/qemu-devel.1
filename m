Received: from eggs.gnu.org ([2001:4830:134:3::10]:41038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNGAt-00011C-Am
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 06:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNGAs-0004j4-DW
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 06:14:19 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNGAs-0004ig-55
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 06:14:18 -0400
Received: by mail-wr0-x22f.google.com with SMTP id y25so49679954wrd.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 03:14:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170614215526.9218-1-jcody@redhat.com>
References: <20170614215526.9218-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 11:13:56 +0100
Message-ID: <CAFEAcA_Oc=fs6sJW9=v57LcEakT3AVVPp4n=S0w3j3s6s+Jhfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 14 June 2017 at 22:55, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 5c3ad1a6a8fa041c57403dbe1fc5927eec0be66b:
>
>   block/iscsi: enable filename option and parsing (2017-06-14 17:39:46 -0400)
>
> ----------------------------------------------------------------
> Block patches
> ----------------------------------------------------------------
>
> Jeff Cody (2):
>   block/rbd: enable filename option and parsing
>   block/iscsi: enable filename option and parsing
>
>  block/iscsi.c | 22 +++++++++++++++++++++-
>  block/rbd.c   | 22 +++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
