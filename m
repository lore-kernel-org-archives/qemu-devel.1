Received: from eggs.gnu.org ([2001:4830:134:3::10]:52941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0eJh-0002Nn-4W
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0eJd-0005bd-Tz
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:26:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54832 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0eJd-0005bD-PL
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 22:26:25 -0400
Date: Tue, 27 Mar 2018 10:26:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327022619.GF17789@xz-mi>
References: <20180326063901.27425-1-peterx@redhat.com>
	<fc8f214d-9e71-8c45-cb0d-b4832c480cd9@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc8f214d-9e71-8c45-cb0d-b4832c480cd9@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/8] Monitor: some oob related
 patches (fixes, new param, tests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Mar 26, 2018 at 12:18:28PM +0200, Christian Borntraeger wrote:
> Thanks for the quick fixing. This series on top of master
> works fine on s390. (make check and iotests)

Appreciate the quick follow up.  Thanks Christian.

-- 
Peter Xu
