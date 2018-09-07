Received: from eggs.gnu.org ([2001:4830:134:3::10]:52060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyHIn-0004NG-Ke
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyHIj-0004ji-GN
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:00:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fyHIj-0004hg-4z
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:59:57 -0400
References: <150508616435.31900.3449336177179115668.malonedeb@soybean.canonical.com>
	<153632111093.28287.15726623039416245550.malone@wampee.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9948c7aa-a74e-99db-fe71-c2fd43593ee3@redhat.com>
Date: Fri, 7 Sep 2018 08:59:49 -0500
MIME-Version: 1.0
In-Reply-To: <153632111093.28287.15726623039416245550.malone@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1716292] Re: User mode emulation returns
 wrong value for write(fd, NULL, 0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1716292 <1716292@bugs.launchpad.net>, qemu-devel@nongnu.org

On 09/07/2018 06:51 AM, Tony Garnock-Jones wrote:
> ** Patch added: "0001-Bring-linux-user-write-2-handling-into-line-with-lin.patch"
>     https://bugs.launchpad.net/qemu/+bug/1716292/+attachment/5186008/+files/0001-Bring-linux-user-write-2-handling-into-line-with-lin.patch

While a developer can chase a URL, our CI tools can't.  Can you please 
also send that patch directly to qemu-devel@nongnu.org, so that it gets 
the same level of review as other patches?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
