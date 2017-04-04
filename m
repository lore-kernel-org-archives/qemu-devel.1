Received: from eggs.gnu.org ([2001:4830:134:3::10]:56461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cvUEN-0007uO-Ly
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cvUEI-0002gM-SM
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:35:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:58556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cvUEI-0002em-LN
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:35:02 -0400
References: <1491325264-14502-1-git-send-email-gsomlo@gmail.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <c092a170-7c72-2999-5bc4-1b7504f66177@suse.de>
Date: Tue, 4 Apr 2017 21:35:00 +0200
MIME-Version: 1.0
In-Reply-To: <1491325264-14502-1-git-send-email-gsomlo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Update AppleSMC for OS X Sierra
 10.12.4 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gabriel L. Somlo" <gsomlo@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, f4bug@amsat.org, eshelton@pobox.com

On 04/04/2017 07:01 PM, Gabriel L. Somlo wrote:
> As of 10.12.4 (currently the latest Sierra update), OS X refuses to boot
> unless the AppleSMC supports a third I/O port, which provides the current
> error status when read.

Looks much nicer after this series :). Thanks a lot!

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
