Received: from eggs.gnu.org ([2001:4830:134:3::10]:45518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWUXy-0008Na-P3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cWUXu-0003vW-OV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:52:02 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:58805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cWUXu-0003v3-Dn
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 15:51:58 -0500
References: <148537694536.27.11791128628902222733@eba24e3a0d7f>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <530dbb21-d944-743f-72b3-2f9820b9e28f@vivier.eu>
Date: Wed, 25 Jan 2017 21:51:41 +0100
MIME-Version: 1.0
In-Reply-To: <148537694536.27.11791128628902222733@eba24e3a0d7f>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: some patches for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, riku.voipio@iki.fi, glaubitz@physik.fu-berlin.de

Le 25/01/2017 à 21:42, no-reply@patchew.org a écrit :
> Hi,
> 
> Your series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Subject: [Qemu-devel] [PATCH 0/2] linux-user: some patches for hppa
> Message-id: 20170125203852.19254-1-laurent@vivier.eu
...
> Checking PATCH 1/2: linux-user: add hppa magic numbers in qemu-binfmt-conf.sh...
> ERROR: line over 90 characters
> #33: FILE: scripts/qemu-binfmt-conf.sh:95:
> +hppa_magic='\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x0f'
> 
> ERROR: line over 90 characters
> #34: FILE: scripts/qemu-binfmt-conf.sh:96:
> +hppa_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>

This error is not relevant for this file...

Thanks,
Laurent
