Received: from eggs.gnu.org ([2001:4830:134:3::10]:46394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyljJ-0002B5-Jr
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cyljI-0007lS-HU
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:52:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cyljI-0007lC-Bf
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:52:36 -0400
Date: Thu, 13 Apr 2017 17:52:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170413205230.GC4376@thinpad.lan.raisama.net>
References: <20170405190024.27581-1-dgilbert@redhat.com>
	<20170405190024.27581-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405190024.27581-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] vmstatification: i386 FPReg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, quintela@redhat.com

On Wed, Apr 05, 2017 at 08:00:23PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Convert the fpreg save/restore to use VMSTATE_ macros rather than
> .get/.put.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Nice!

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
