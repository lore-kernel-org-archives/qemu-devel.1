Received: from eggs.gnu.org ([2001:4830:134:3::10]:48361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cttVe-0003no-Vn
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cttVe-00065S-0T
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:10:22 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cttVd-00062z-Pe
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:10:21 -0400
Received: by mail-wr0-x22c.google.com with SMTP id w43so98465583wrb.0
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 03:10:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490922956-19731-1-git-send-email-jasowang@redhat.com>
References: <1490922956-19731-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Mar 2017 11:09:58 +0100
Message-ID: <CAFEAcA-A_P8bTE1gTTQqgvdMAP7gLqfpdDSUyAJ6qWrZr6+zjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 March 2017 at 02:15, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit ddc2c3a57e0752c0650fdb735a8b8322542d4248:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-30 18:02:33 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to b4053c64833762f1249b2d704d2da30b5b10c8ff:
>
>   e1000: disable debug by default (2017-03-31 08:48:13 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Jason Wang (2):
>       virtio-net: avoid call tap_enable when there's only one queue
>       e1000: disable debug by default
>
>  hw/net/e1000.c      | 2 +-
>  hw/net/virtio-net.c | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
