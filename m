Received: from eggs.gnu.org ([2001:4830:134:3::10]:52383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDVbR-000527-BH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDVbP-0000CR-Lf
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:18:13 -0400
Date: Fri, 19 Oct 2018 11:18:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181019141801.GF31060@habkost.net>
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-8-mreitz@redhat.com>
	<14120cdc-1517-f9af-9f35-3c78b4f634a9@redhat.com>
	<20181015235752.GK31060@habkost.net>
	<0287ec2e-9ab7-2fd3-4abf-1c84a97f0e07@redhat.com>
	<454c0ced-e3d9-e447-9e2b-ef8badb808d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454c0ced-e3d9-e447-9e2b-ef8badb808d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/9] iotests: 'new' module replacement in
 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, Oct 19, 2018 at 11:46:59AM +0200, Max Reitz wrote:
[...]
> I mean, my personal goal is not to touch this beyond what I need to
> because it's black magic to me anyway, so I'm happy with what works.

I agree with this approach, and your original patch looks good
enough to me.

-- 
Eduardo
