Received: from eggs.gnu.org ([2001:4830:134:3::10]:53414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEdnS-0001k1-PL
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:10:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEdnR-0006py-R3
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:10:46 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:48869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEdnR-0006o9-KT
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:10:45 -0500
Received: by mail-wr0-x235.google.com with SMTP id 15so17942823wrb.5
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 08:10:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171114043747.4810-1-david@gibson.dropbear.id.au>
References: <20171114043747.4810-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2017 16:10:24 +0000
Message-ID: <CAFEAcA-ExHoVFuP2tztdHX-FejJ_zxk=TRc=hCc38VXJQnmKig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-2.11 queue 20171114
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 14 November 2017 at 04:37, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 4e8a737c092d25fe5ff99ac7bff01c222c1c017d:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20171110-pull-request' into staging (2017-11-13 14:33:29 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171114
>
> for you to fetch changes up to dcb556fc6ad879f7d29fb233a273a1ea3aa0549c:
>
>   xics/kvm: synchonize state before 'info pic' (2017-11-14 11:12:42 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2017-11-14
>
> Another couple of fixes for qemu-2.11.
>
> ----------------------------------------------------------------
> Greg Kurz (1):
>       xics/kvm: synchonize state before 'info pic'
>
> Sam Bobroff (1):
>       target/ppc: correct htab shift for hash on radix

Applied, thanks.

-- PMM
