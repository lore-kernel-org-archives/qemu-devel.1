Received: from eggs.gnu.org ([2001:4830:134:3::10]:33660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZ0GQ-0003jz-4U
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZ0GP-0007cM-BQ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:12:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eZ0GP-0007bv-5h
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:12:49 -0500
Date: Tue, 9 Jan 2018 18:12:41 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180109201241.GG18022@localhost.localdomain>
References: <20171125151610.20547-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171125151610.20547-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Replace has_dynamic_sysbus with
 list of allowed device types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Queued on machine-next.

-- 
Eduardo
