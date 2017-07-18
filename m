Received: from eggs.gnu.org ([2001:4830:134:3::10]:38899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXZdU-00026N-7U
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXZdT-00023a-Eu
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:02:28 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXZdT-000230-7o
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:02:27 -0400
Received: by mail-wr0-x236.google.com with SMTP id w4so45433579wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 14:02:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500369144-143949-1-git-send-email-borntraeger@de.ibm.com>
References: <1500369144-143949-1-git-send-email-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 22:02:05 +0100
Message-ID: <CAFEAcA-Sfn+Y8M0rkJAnYBFCLocNSeZeWzmhFLA5BtNMJfvPYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] two more s390 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

On 18 July 2017 at 10:12, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> Peter,
> now that z14 was announced here is the z14 cpu model together with
> the linux header update.
>
> The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)
>
> are available in the git repository at:
>
>   git://github.com/borntraeger/qemu.git tags/s390x-20170718
>
> for you to fetch changes up to cc28a5949bb54df070c38ab505ee2c14385e53d0:
>
>   s390x/cpumodel: z14 cpu models (2017-07-18 10:55:16 +0200)
>
> ----------------------------------------------------------------
> s390: add z14 cpu model
>
> - add a CPU model for the IBM z14 which was announced on July 17th 2017
> - update linux headers to 4.13-rc0 to get a fix for an ioctl definition
>
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       linux header sync against v4.13-rc1
>
> Jason J. Herne (1):
>       s390x/cpumodel: z14 cpu models
>

Applied, thanks.

-- PMM
