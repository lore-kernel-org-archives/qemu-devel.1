Received: from eggs.gnu.org ([2001:4830:134:3::10]:50388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fl9yk-0008Kd-Hl
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fl9yg-0004Hv-Lw
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:33:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fl9yg-0004HR-HB
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:33:02 -0400
Date: Thu, 2 Aug 2018 10:32:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180802093258.GA2524@work-vm>
References: <D96C38EF-891A-464A-B15F-31B4235147BD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D96C38EF-891A-464A-B15F-31B4235147BD@gmail.com>
Subject: Re: [Qemu-devel] QEMU 3.0 RC3 mouse problem with Windows 3.1 and NT
 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

* Programmingkid (programmingkidx@gmail.com) wrote:
> The mouse cursor stops working properly under Windows 3.1 and Windows NT 4.0 after a few minutes of use. The cursor will want to stay at the very edges of the QEMU window. 

Can you try and bisect which change caused the problem?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
