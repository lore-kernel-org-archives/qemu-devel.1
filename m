Received: from eggs.gnu.org ([2001:4830:134:3::10]:43112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0Ca0-0001kv-73
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 17:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0CZz-0006Fa-J0
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 17:21:44 -0400
References: <20180622112237.2131-1-gersner@gmail.com>
	<CAGFXeQL4FPVeFrEiQpRjGnBMBs5oCjxjXFJ_NGWsGmOjvk75pg@mail.gmail.com>
	<CALKrh6mPkirNjwkCMLWU4d+eQnnkYDmjPVAWccP4K4tQDxxLaA@mail.gmail.com>
	<CAGFXeQKjnCvY7hRw_1MxZOROhHbsdHM9YPL-QzzWeJZcu0A8Jg@mail.gmail.com>
	<CALKrh6kHp05SjoQ-YMecejj=TxHUFY9P-gCmW3E5wDFRCnP2mQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <225d23ef-d092-40a0-494a-1da276174bec@redhat.com>
Date: Wed, 12 Sep 2018 16:21:36 -0500
MIME-Version: 1.0
In-Reply-To: <CALKrh6kHp05SjoQ-YMecejj=TxHUFY9P-gCmW3E5wDFRCnP2mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] nvme: PCI/e configuration from
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gersner <gersner@gmail.com>, daniel@drv.nu
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, David S <davidsa@openu.ac.il>

On 9/12/18 2:53 PM, Gersner wrote:
> Hi Daniel,
> 
> Sorry for the long round-trips, we had a busy month. We have implemented
> all the changes. Waiting for a final clarification.
> 
> Should the new patches be posted on this thread or a new one?

Best to post a v2 as a new top-level thread (our CI tools don't spot 
patch revisions buried in reply to an existing thread).

Also, it's best to avoid top-posting on technical lists, as it's harder 
to follow the flow of your email.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
