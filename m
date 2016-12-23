Received: from eggs.gnu.org ([2001:4830:134:3::10]:58256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKOhu-0003PO-US
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 07:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cKOhp-00088O-TA
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 07:12:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cKOhp-00088C-N7
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 07:12:13 -0500
References: <20161222152300.32395-1-pbonzini@redhat.com>
	<CAFEAcA_EyA1WycYOoqZP767GiufX=DV59v4Hgb=dhk+NoE3X5w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c86185e-a0bb-504e-c8eb-94e07530ed2e@redhat.com>
Date: Fri, 23 Dec 2016 13:12:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_EyA1WycYOoqZP767GiufX=DV59v4Hgb=dhk+NoE3X5w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] First round of misc patches for QEMU
 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 23/12/2016 12:15, Peter Maydell wrote:
>> * core support for MemoryRegionCache from myself
>> * rules.mak speedup and cleanups from myself and Marc-Adnr=E9
>> * multiboot command line fix from Vlad
>> * SCSI fixes from myself
>> * small qemu-timer speedup from myself
>> * x86 debugging improvements from Doug
>> * configurable Q35 devices from  Chao
>> * x86 5-level paging support from Kirill
>> * x86 SHA_NI support for KVM from Yi Sun
>> * improved kvmclock migration logic from Marcelo
>> * bugfixes and doc fixes from others
> Applied, thanks. (Nice to see that git is smart enough to
> be able to merge this on top of the earlier target-* rename.)

Actually I did the rebase myself.  But yes, I also hardly noticed the
rename.

Paolo
