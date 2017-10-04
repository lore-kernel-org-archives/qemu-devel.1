Received: from eggs.gnu.org ([2001:4830:134:3::10]:33834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzcTq-0007f9-L9
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dzcTl-0005Ud-PI
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dzcTl-0005Tw-JL
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:44:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171004030025.7866-1-ehabkost@redhat.com>
	<20171004030025.7866-3-ehabkost@redhat.com>
Date: Wed, 04 Oct 2017 07:44:18 +0200
In-Reply-To: <20171004030025.7866-3-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Wed, 4 Oct 2017 00:00:25 -0300")
Message-ID: <87y3ortqkt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/2] qemu-options: Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
> have no default config files that would be disabled using
> -nodefconfig.  Update documentation and document -nodefconfig as
> deprecated.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
