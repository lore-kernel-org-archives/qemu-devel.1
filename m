Received: from eggs.gnu.org ([2001:4830:134:3::10]:49504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGqVj-0004KL-Qw
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGqVi-0002N9-Rf
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:37:19 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGqVi-0002Mj-JO
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 13:37:18 -0400
Received: by mail-wm0-x235.google.com with SMTP id n195so32322320wmg.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 10:37:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496421247-857-1-git-send-email-mst@redhat.com>
References: <1496421247-857-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 18:36:56 +0100
Message-ID: <CAFEAcA82qse_veoF2=pbd+qOw9vODAZZ4fn4bvEg-1=5yPm5qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] virtio, vhost: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 June 2017 at 17:34, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit d47a851caeda96d5979bf48d4bae6a87784ad91d:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170601' into staging (2017-06-02 14:07:53 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 6dcdd06e3b0d0c5651219013ec975348e2050041:
>
>   spec/vhost-user spec: Add IOMMU support (2017-06-02 18:57:17 +0300)
>
> ----------------------------------------------------------------
> virtio, vhost: fixes, features
>
> IOTLB support in vhost-user.
> A bunch of fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
