Received: from eggs.gnu.org ([2001:4830:134:3::10]:49680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1crSJs-0004fC-CS
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1crSJp-0006cZ-8D
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:44:08 -0400
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com
	([104.47.32.74]:27777
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1crSJo-0006c2-U8
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:44:05 -0400
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900628810.27090.3461280348833651824.stgit@brijesh-build-machine>
	<20170323112922.GB12560@stefanha-x1.localdomain>
	<b3cc6807-9cac-968a-0759-60a203102751@amd.com>
	<20170324153613.GA5849@stefanha-x1.localdomain>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <2938b8d3-dafe-e706-e974-50a83d79cee1@amd.com>
Date: Fri, 24 Mar 2017 11:43:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170324153613.GA5849@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 02/20] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: brijesh.singh@amd.com, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com



On 03/24/2017 10:36 AM, Stefan Hajnoczi wrote:
>
> I suggest something like this instead:
>
>   /* Debug memory access for AMD SEV */
>
> That way it's clear this "debug" flag has a very specific meaning in the
> context of memory encryption.
>

Sure, will update comments.

-Brijesh
