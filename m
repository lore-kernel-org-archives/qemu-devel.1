Received: from eggs.gnu.org ([2001:4830:134:3::10]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1edvmK-0002Gb-U5
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1edvmH-0007nd-La
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:26:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:38171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1edvmH-0007mC-EW
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:26:05 -0500
From: Andreas Schwab <schwab@suse.de>
References: <mvmk1w9lreq.fsf@suse.de>
	<40b82ee1-416b-20c6-4745-218d8e3cdd24@vivier.eu>
Date: Tue, 23 Jan 2018 11:26:04 +0100
In-Reply-To: <40b82ee1-416b-20c6-4745-218d8e3cdd24@vivier.eu> (Laurent
	Vivier's message of "Tue, 23 Jan 2018 01:37:58 +0100")
Message-ID: <mvminbsub0j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] linux-user: implement renameat2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

On Jan 23 2018, Laurent Vivier <laurent@vivier.eu> wrote:

> And, please, test it (build/run).

This was tested by bootstrapping openSUSE Factory for RISC-V.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
