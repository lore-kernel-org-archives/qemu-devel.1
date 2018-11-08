Received: from eggs.gnu.org ([2001:4830:134:3::10]:60670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKlZ4-0007Mb-UR
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKlZ4-0006da-5q
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:45:46 -0500
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b123d5e2-7262-a695-a53c-8fce888a7ce0@redhat.com>
Date: Thu, 8 Nov 2018 08:45:43 -0600
MIME-Version: 1.0
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/22] ppc-for-3.1 queue 20181108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: lvivier@redhat.com, agraf@suse.de, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org

On 11/8/18 6:16 AM, David Gibson wrote:
> The following changes since commit 4de6bb0c02ad3f0ec48f0f84ba1a65ab06e81b86:
> 
>    Update version for v3.1.0-rc0 release (2018-11-06 18:27:35 +0000)
> 

> 
> Maria Klimushenkova (1):
>        This patch fixes processing of rfi instructions in icount mode.

Repeating the comment on 20/22 here, in case David wants to send a v2 
respin of the PR before Peter applies this subject line as-is.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
