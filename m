Received: from eggs.gnu.org ([2001:4830:134:3::10]:34383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cIwCH-0006UB-HV
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cIwCE-0005s2-Ey
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:33:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cIwCE-0005qw-9I
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:33:34 -0500
Date: Fri, 16 Dec 2016 13:59:09 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20161216155909.GA22751@amt.cnet>
References: <20161210172148.361793326@redhat.com>
	<20161210172324.482367805@redhat.com>
	<ccb8c6bf-f136-9a6c-fbdc-7e7d4924321e@redhat.com>
	<20161216134136.GV3808@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161216134136.GV3808@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [qemu patch V4 2/2] kvmclock: reduce kvmclock
 difference on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Dr David Alan Gilbert <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

On Fri, Dec 16, 2016 at 11:41:36AM -0200, Eduardo Habkost wrote:
> On Fri, Dec 16, 2016 at 11:03:33AM +0100, Paolo Bonzini wrote:
> > I'd like to make a few cleanups and add more documentation:
> > 
> 
> Looks good to me.
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

+1
