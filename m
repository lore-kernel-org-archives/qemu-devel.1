Received: from eggs.gnu.org ([209.51.188.92]:49725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gmayR-0006or-CX
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gmayE-0005OC-D2
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:06:47 -0500
Date: Thu, 24 Jan 2019 09:57:43 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190124085743.GE23279@paraplu>
References: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMAMwPB1GJNxsgcvZLHwHuLp-AjuWtnYCGOm6+U4DwdLsNrU8A@mail.gmail.com>
Subject: Re: [Qemu-devel] Incremental drive-backup with dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharadwaj Rayala <bharadwaj.rayala@rubrik.com>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org, Suman Swaroop <suman.swaroop@rubrik.com>, kashyap.cv@gmail.com

On Wed, Jan 23, 2019 at 12:59:27AM +0530, Bharadwaj Rayala wrote:

[...]

Eric has responded with excellent detail, as usual; a "meta question"
below.

> I am trying to build a backup workflow(program) using drive-backup along
> with dirty bitmaps to take backups of kvm vms. 

Is this program that you're building just specific to your environment?
Or is it a generic open source project (or proprietary product)?

> EIther pull/push model works for me. Since drive-backup push model is
> already implemented, I am going forward with it. I am not able to
> figure out a few details and couldn't find any documentation around
> it. Any help would be appreciated

[...]


-- 
/kashyap
