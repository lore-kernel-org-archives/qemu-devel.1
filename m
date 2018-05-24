Received: from eggs.gnu.org ([2001:4830:134:3::10]:49278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLvrD-0007Uc-2m
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLvrA-0007Uw-Ev
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:25:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fLvrA-0007Ua-9W
	for qemu-devel@nongnu.org; Thu, 24 May 2018 15:25:00 -0400
Date: Thu, 24 May 2018 16:24:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180524192455.GL8988@localhost.localdomain>
References: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
	<4e7811da-f900-bbf4-ea88-cf8983a6675f@tripleback.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7811da-f900-bbf4-ea88-cf8983a6675f@tripleback.net>
Subject: Re: [Qemu-devel] [PATCH v11 0/5] i386: Enable TOPOEXT to support
 hyperthreading on AMD CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kash Pande <kash@tripleback.net>
Cc: Babu Moger <babu.moger@amd.com>, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com

On Thu, May 24, 2018 at 11:51:29AM -0400, Kash Pande wrote:
> Tested-by: Kash Pande <kash@tripleback.net>
> 
> 
> Hopefully we can get this merged because it's taken a ridiculously long
> time with many back-and-forths for small issues that could have been put
> off til later.

I understand this is frustrating, and this is partly my fault
because I didn't detect the issues on the first versions of the
series.  Sorry for that.

I believe the patches that weren't included yet either had bugs
that had to be solved, or depended on other patches that were not
included yet.  If there are patches from other iterations of this
series where you consider the code already ready for inclusion,
please let me know.  Reviewed-by lines are welcome.

-- 
Eduardo
