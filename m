Received: from eggs.gnu.org ([2001:4830:134:3::10]:56289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drpAg-0004wL-KG
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drpAc-0005ro-Nh
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:40:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1drpAc-0005rB-Hv
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:40:22 -0400
Date: Tue, 12 Sep 2017 14:40:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170912174017.GB7570@localhost.localdomain>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-50-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170911110623.24981-50-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 49/50] qapi: make
 query-cpu-model-expansion depend on s390 or x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Mon, Sep 11, 2017 at 01:06:22PM +0200, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
