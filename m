Received: from eggs.gnu.org ([2001:4830:134:3::10]:34117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOu5-0004x2-QU
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOu2-0006qN-Ld
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:13:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGOu2-0006pI-Ew
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:13:06 -0400
References: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c500726-bd2d-2261-68ec-dd39c98d06aa@redhat.com>
Date: Wed, 9 May 2018 08:13:02 -0500
MIME-Version: 1.0
In-Reply-To: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/7] hmat acpi: Build Memory Subsystem
 Address Range Structre(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liu Jingqi <jingqi.liu@intel.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On 05/09/2018 03:34 AM, Liu Jingqi wrote:

In the subject line: s/Structre/Structure/

Long subject line; read 'git shortlog -30' to get a feel for more 
typical subjects, and try to keep it at 60 characters or less (you still 
want legible subjects in an 80-column window even when git adds 
indentation and/or abbreviated commit id prefixes)

> HMAT is defined in ACPI 6.2: 5.2.27 Heterogeneous Memory Attribute Table (HMAT).
> The specification references below link:
> http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf

Also, your mail was sent without any In-Reply-To: or References: 
headers, meaning it was not threaded to a 0/7 cover letter, but instead 
7 different top-level threads.  That makes it harder to track replies to 
your thread.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
