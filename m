Received: from eggs.gnu.org ([2001:4830:134:3::10]:33980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gUrw2-0006Z2-1G
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gUrvx-0000w8-Qx
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:35:13 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:46849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <public@hansmi.ch>) id 1gUrvx-0000t4-Jb
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:35:09 -0500
References: <20181206084816.30485-1-ppandit@redhat.com>
From: Michael Hanselmann <public@hansmi.ch>
Message-ID: <9aeed20e-7d76-8e96-d97c-b56d6c159c54@msgid.hansmi.ch>
Date: Thu, 6 Dec 2018 12:35:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181206084816.30485-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 06.12.18 09:48, P J P wrote:
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Michael Hanselmann <public@hansmi.ch>

Best regards,
Michael
