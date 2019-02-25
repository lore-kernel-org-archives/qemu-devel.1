Received: from eggs.gnu.org ([209.51.188.92]:47219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyGqr-0003aP-Oa
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyGql-0007C2-Qm
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:03:25 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:44217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyGqj-0007Ak-Oc
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:03:18 -0500
Received: by mail-ot1-x334.google.com with SMTP id g1so7851823otj.11
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 06:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20190222082436.23029-1-kraxel@redhat.com>
In-Reply-To: <20190222082436.23029-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 14:03:02 +0000
Message-ID: <CAFEAcA8Tv9SdOq=teRn+y_MByMKhszEi1cn9u0MhLSjQRf3yWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Vga 20190222 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 22 Feb 2019 at 08:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 2e68b8620637a4ee8c79b5724144b726af1e261b:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190219' into staging (2019-02-18 16:20:13 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190222-pull-request
>
> for you to fetch changes up to 1ed2cb32dc9e8f74c82bdc567edad717b0f34fa5:
>
>   display/virtio: add edid support. (2019-02-22 07:25:04 +0100)
>
> ----------------------------------------------------------------
> vga: bugfixes and edid support for virtio-vga
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
