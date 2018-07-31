Received: from eggs.gnu.org ([2001:4830:134:3::10]:54112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkRew-0003sl-Nx
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkRev-0008Fm-RV
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:13:42 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:36355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkRev-0008Ey-Kp
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 06:13:41 -0400
Received: by mail-oi0-x231.google.com with SMTP id n21-v6so26903974oig.3
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 03:13:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180731065057.23710-1-cohuck@redhat.com>
References: <20180731065057.23710-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jul 2018 11:13:20 +0100
Message-ID: <CAFEAcA-YYF8cSM3EuCy6tQJqrTJxD7Msyyif+RyeG_+M4ch-ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.0 0/1] s390x fix for -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 31 July 2018 at 07:50, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc:
>
>   Update version for v3.0.0-rc2 release (2018-07-24 22:06:31 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180731
>
> for you to fetch changes up to 408e5ace517ff18c9c7cd918fc93358162e6e26d:
>
>   s390x/sclp: fix maxram calculation (2018-07-30 17:41:52 +0200)
>
> ----------------------------------------------------------------
> fix large guests on s390x
>

Applied, thanks.

-- PMM
