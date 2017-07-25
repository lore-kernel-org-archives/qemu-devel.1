Received: from eggs.gnu.org ([2001:4830:134:3::10]:48998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZyXp-0002EJ-0R
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZyXo-0006bK-8o
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:02:33 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZyXo-0006ax-25
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:02:32 -0400
Received: by mail-wm0-x229.google.com with SMTP id t201so43787192wmt.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 05:02:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725094026.5376-1-cohuck@redhat.com>
References: <20170725094026.5376-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2017 13:02:10 +0100
Message-ID: <CAFEAcA8qDfGYQCLaCbLQXP4Fyi0Utq4D+c5J97sYM6AEa869yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 00/14] A set of s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

On 25 July 2017 at 10:40, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit b5a74cd81d76cb467552f38f2b39520d07c65ea2:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170724' into staging (2017-07-24 18:15:45 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170725
>
> for you to fetch changes up to 7e01376daea75e888c370aab521a7d4aeaf2ffd1:
>
>   s390x/css: fix ilen in IO instruction handlers (2017-07-25 09:17:42 +0200)
>
> ----------------------------------------------------------------
> Various changes for the s390x code:
> - updates for cpu model handling
> - fix compilation with --disable-tcg
> - fixes in vfio-ccw and I/O instruction handling
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
