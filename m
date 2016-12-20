Received: from eggs.gnu.org ([2001:4830:134:3::10]:54639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cJPfS-00015M-Nh
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cJPfN-0002z2-T8
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:01:42 -0500
Received: from [2a03:4000:1::4e2f:c7ac:d] (port=49000 helo=mail.weilnetz.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cJPfN-0002yk-MU
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 14:01:37 -0500
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <5f886aaf-b50a-481f-ed9d-4aeecc5dedc2@weilnetz.de>
Date: Tue, 20 Dec 2016 20:01:28 +0100
MIME-Version: 1.0
In-Reply-To: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/7] Move accel, KVM, Xen,
 qtest files to accel/ subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, kvm@vger.kernel.org, xen-devel@lists.xensource.com, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On 12/20/16 18:43, Eduardo Habkost wrote:
> This moves the KVM and Xen files to the an accel/ subdir.

I hope that it won't last long until we also get acceleration
for Windows and macOS. Those HAXM files will have to be moved
as well.

Regards,
Stefan
