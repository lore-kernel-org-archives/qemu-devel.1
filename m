Received: from eggs.gnu.org ([2001:4830:134:3::10]:32924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5pUT-0003Ab-4h
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5pUN-0005B0-AM
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:23:01 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:33551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5pUN-0005Ag-54
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:22:55 -0400
Received: by mail-ot0-x22a.google.com with SMTP id 23-v6so11946976otj.0
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 02:22:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180409151533.2253-1-cohuck@redhat.com>
References: <20180409151533.2253-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 10:22:34 +0100
Message-ID: <CAFEAcA9COtfPpEh_wY2roqSEb-KpPXprGhrm7ZYq3=qUi6j3uQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.12 0/8] s390x fixes for -rc3
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

On 9 April 2018 at 16:15, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 2a6bcfdebe4115993a032395d459f5e0cf27a01e:
>
>   Merge remote-tracking branch 'remotes/famz/tags/testing-pull-request' into staging (2018-04-09 10:21:14 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180409
>
> for you to fetch changes up to b3a184f51fbed3401694a9619e6842f882a64fee:
>
>   s390x: load_psw() should only exchange the PSW for KVM (2018-04-09 13:59:06 +0200)
>
> ----------------------------------------------------------------
> Fixes for s390x: kvm, vfio-ccw, ipl code, bios. Includes a rebuild
> of s390-ccw.img and s390-netboot.img.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
