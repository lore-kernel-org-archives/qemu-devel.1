Received: from eggs.gnu.org ([2001:4830:134:3::10]:42226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cblLp-0004E9-O6
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 04:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cblLm-0001Ig-M8
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 04:49:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cblLm-0001Ic-Gj
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 04:49:14 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A4DD7FB85
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 09:49:14 +0000 (UTC)
Date: Thu, 9 Feb 2017 10:49:10 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170209094910.mrfhyjixmwr5kofb@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<3fa3d4b8-3e3a-d6c4-a2c1-affef7361576@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa3d4b8-3e3a-d6c4-a2c1-affef7361576@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, marcel@redhat.com, kraxel@redhat.com

On Wed, Feb 08, 2017 at 07:11:42PM +0100, Laszlo Ersek wrote:
> > +# RHEL:
> > +#   /usr/share/AAVMF/AAVMF_CODE.fd
> > +#   /usr/share/AAVMF/AAVMF_VARS.fd
> 
> Looks legit. (Might want to call "RHEL" "RHELSA" though, in this context
> -- no clue. Ask Drew :))
>

The first choice "RHEL" is correct. "RHELSA" still exists today,
but eventually that name should be phased out (IIUC), as AArch64
will be "just another RHEL arch", requiring no special name.

Thanks,
drew
