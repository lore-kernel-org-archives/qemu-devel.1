Received: from eggs.gnu.org ([2001:4830:134:3::10]:37659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ch1OU-00044N-0C
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ch1OT-0008E8-1Y
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:57:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1ch1OS-0008Dk-S7
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 16:57:44 -0500
Date: Thu, 23 Feb 2017 21:57:41 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170223215740.GD13825@redhat.com>
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<20170223200747.GO2778@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170223200747.GO2778@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] i386: Add "max" CPU model to TCG
 and KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Feb 23, 2017 at 05:07:47PM -0300, Eduardo Habkost wrote:
> Ping?
> 
> As v1 was sitting on the list since Jan 19, if there are no
> objections I will merge this and include in my next pull request
> before soft freeze.

Do you have a copy which applies on top of current HEAD?  I get
loads of conflicts.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
