Received: from eggs.gnu.org ([2001:4830:134:3::10]:35209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cTUGb-00008O-JD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cTUGX-0007mt-1z
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:57:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cTUGW-0007ma-Rz
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:57:36 -0500
Date: Tue, 17 Jan 2017 13:57:34 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170117135734.GD14855@redhat.com>
References: <20170116195452.23532-1-ehabkost@redhat.com>
	<20170117134208.GB14855@redhat.com>
	<20170117134440.GC14855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170117134440.GC14855@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>


Oh no wait, these errors are just because of the new version of qemu
that I am using to test your patch, so nothing to do with this patch.

/me fires up git bisect ...

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
