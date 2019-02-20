Received: from eggs.gnu.org ([209.51.188.92]:36435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwVBG-0004WS-0A
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwVBF-0005iW-6s
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:57:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gwVBF-0005PK-0B
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:57:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<87y36bjeex.fsf@dusky.pond.sub.org>
	<BN6PR2201MB12512010AACFBA5DAC2FAE7FC67D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Date: Wed, 20 Feb 2019 17:50:48 +0100
In-Reply-To: <BN6PR2201MB12512010AACFBA5DAC2FAE7FC67D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	(Aleksandar Markovic's message of "Wed, 20 Feb 2019 12:32:19 +0000")
Message-ID: <87wolus8t3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP
 query-cpu-definitions command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>, "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>, "natalia.fursova@ispras.ru" <natalia.fursova@ispras.ru>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

Aleksandar Markovic <amarkovic@wavecomp.com> writes:

>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP query-cpu-definitions command
>
> ...
>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Unless there is somebody's objection, I am going to accept this patch into the next
> MIPS pull request, planned to be sent in next few days.

As far as I'm concerned: go right ahead.
