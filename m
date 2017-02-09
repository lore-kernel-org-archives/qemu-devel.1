Received: from eggs.gnu.org ([2001:4830:134:3::10]:56226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbpWM-0004MP-Kh
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cbpWI-0001nw-C8
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:16:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cbpWI-0001nP-6f
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:16:22 -0500
Date: Thu, 9 Feb 2017 22:16:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170209141618.GL22807@lemon.lan>
References: <CAO_EM_m9Z7WcxRZthAGgeDgJ6UuwKXwAOEH7NC2=hL8Cd4jABg@mail.gmail.com>
	<20170209014728.GF22807@lemon.lan>
	<CAO_EM_mJYNoxTLjKmTy18JhrL_zs_VLA32Y=Cw+LYqAGPzLN=w@mail.gmail.com>
	<20170209025212.GG22807@lemon.lan>
	<CAO_EM_kh1mQZNhjRKi458u15kj0G6t=UEFBvM+wWhOX1fyi6VQ@mail.gmail.com>
	<20170209101240.GJ22807@lemon.lan>
	<CAO_EM_mhnd9-2B3vpLDa5eCyMh17e4UCYqe6nu-UqSDfhNAivA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_EM_mhnd9-2B3vpLDa5eCyMh17e4UCYqe6nu-UqSDfhNAivA@mail.gmail.com>
Subject: Re: [Qemu-devel] virtio-scsi-pci iothread spins at 100%
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Thu, 02/09 05:52, Ed Swierk wrote:
> On Thu, Feb 9, 2017 at 2:12 AM, Fam Zheng <famz@redhat.com> wrote:
> > This should fix it:
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01874.html
> 
> I tested this patch and found it fixes the problem. Thanks for the
> speedy response!

Thanks for the testing! If you could reply to the patch with a "Tested-by:" line
that would be even better. :)

Fam
