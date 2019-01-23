Received: from eggs.gnu.org ([209.51.188.92]:47189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gm8o2-0003jG-2o
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gm8o0-0001uj-Bc
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:02:21 -0500
Received: from server54-2.web-hosting.com ([198.54.126.118]:38916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <admin@grossmann-venter.com>)
	id 1gm8nz-0001lt-WA
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:02:20 -0500
Received: from [::1] (port=58636 helo=server54.web-hosting.com)
	by server54.web-hosting.com with esmtpa (Exim 4.91)
	(envelope-from <admin@grossmann-venter.com>) id 1gm8np-0007X2-D2
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 22:02:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Jan 2019 22:02:09 -0500
From: liebrecht@grossmann-venter.com
Message-ID: <720ebdfeb9506e0719481fc1913c9272@grossmann-venter.com>
Subject: [Qemu-devel] networking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The windows 7 guest on linux host had networking out of the box.
It now lost it for some reason.
The qemu string remained the same....

It now want to do DHCP and fails.
It has an intel nic as nic device in device manager.

What i cant understand is how to dop a static network config in this 
case.
lets say my network is 192.168.1.x

Do i give it a static ip say 192.168.1.33 ?
The mask 255.255.255.0
What must the default gateway be ?
On my linux network this at 192.168.1.100

Should I give an external e.g. google dns or is there a specific 
internal DNS it needs to use ?

thanks

Why networking just broke I really cannot understand
