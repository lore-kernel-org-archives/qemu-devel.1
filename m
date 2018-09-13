Received: from eggs.gnu.org ([2001:4830:134:3::10]:49434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0Nb1-0002gv-EL
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 05:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0Naw-0008Mc-AS
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 05:07:31 -0400
References: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
	<20180910204631.24106-3-mark.cave-ayland@ilande.co.uk>
	<20180913002457.GN7978@umbus.fritz.box>
	<b54d9b4a-8b04-bdc7-2117-0a7909607c6c@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <faf7c016-0321-8dff-e102-0bcd59f4a7d5@redhat.com>
Date: Thu, 13 Sep 2018 11:07:19 +0200
MIME-Version: 1.0
In-Reply-To: <b54d9b4a-8b04-bdc7-2117-0a7909607c6c@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] 40p: add fixed IRQ routing for LSI
 SCSI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>
Cc: famz@redhat.com, qemu-ppc@nongnu.org, hpoussin@reactos.org, qemu-devel@nongnu.org

On 13/09/2018 06:21, Mark Cave-Ayland wrote:
> Indeed, see the Based-on header attached to the cover letter: it is
> dependent upon the lsi53c8xx_create() removal patchset at
> https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00797.html
> which Paolo has queued here:
> https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg01209.html.
> 
> Rather than having to juggle the order of pull requests, would it make
> sense for you to take the the lsi53c8xx_create() removal patchset via
> ppc-for-3.1 aswell?
> 

No objections from me.

Paolo
