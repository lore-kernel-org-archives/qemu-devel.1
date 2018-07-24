Received: from eggs.gnu.org ([2001:4830:134:3::10]:56084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fi4UU-0002dd-4O
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fi4UT-00023U-Bw
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:05:06 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fi4UT-00023C-6M
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 17:05:05 -0400
Received: by mail-oi0-x242.google.com with SMTP id q11-v6so10051770oic.12
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 14:05:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180724183454.120276-1-dgilbert@redhat.com>
References: <20180724183454.120276-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 22:04:43 +0100
Message-ID: <CAFEAcA_Lyh69KjBeYZkn-g8hOg1gqMGEUy2L21NUtRrfCCW4Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] migration queue for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, lidongchen@tencent.com, Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On 24 July 2018 at 19:34, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 3bae150448dbd888a480f892ebbf01caec0d8329:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-07-24 15:26:01 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180724a
>
> for you to fetch changes up to 4b3fb65db973b51346e3456987ba80b15c1fc75c:
>
>   migration: fix duplicate initialization for expected_downtime and cleanup_bh (2018-07-24 17:28:57 +0100)
>
> ----------------------------------------------------------------
> Migration pull for 3.0
>
> Fixes only
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
