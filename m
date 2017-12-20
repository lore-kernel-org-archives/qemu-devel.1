Received: from eggs.gnu.org ([2001:4830:134:3::10]:36603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kirill.shutemov@linux.intel.com>) id 1eReQb-0004AI-S8
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kirill.shutemov@linux.intel.com>) id 1eReQY-0008AR-IJ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:28:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:20874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kirill.shutemov@linux.intel.com>)
	id 1eReQY-000884-AB
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:28:54 -0500
Date: Wed, 20 Dec 2017 16:26:49 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20171220132649.oh7ma5j3ubabi2gc@black.fi.intel.com>
References: <20171103152824.21948-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171103152824.21948-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] mux chardev events regression fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Fri, Nov 03, 2017 at 03:28:22PM +0000, Marc-André Lureau wrote:
> Hi,
> 
> The following patches fix and test the behaviour of mux chardev
> events, after a regression introduced in qemu 2.8.0.
> 
> v1->v2:
> - fix incompatible pointer type warning spotted by patchew

Looks like this patchset got stuck and never reached upsteam.

Any update on this?

-- 
 Kirill A. Shutemov
