Received: from eggs.gnu.org ([2001:4830:134:3::10]:57678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMEJw-0004UG-MU
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMEJu-0005rS-28
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:40:12 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59927)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMEJt-0005o6-BD
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:40:09 -0500
References: <1540300056-7935-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540300056-7935-4-git-send-email-aleksandar.markovic@rt-rk.com>
	<33595f9c-b463-d3c1-dcad-ec0aae1c67af@vivier.eu>
	<BN6PR2201MB12514AA001E055E5B1B9738FC6C10@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f9cc3e26-831d-1fa5-58d6-fbe767864624@vivier.eu>
Date: Mon, 12 Nov 2018 16:39:29 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12514AA001E055E5B1B9738FC6C10@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] linux-user: Add support for
 SO_REUSEPORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, Yunqiang Su <ysu@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

On 12/11/2018 16:29, Aleksandar Markovic wrote:
> Hi, Laurent. Is there any chance that from this series this patch only makes into 3.1? One can argue that this is a bug fix, but it is your call.

Hi Aleksandar,

yes, I'm adding this patch to my next pull-request (for today or tomorrow).

Thanks,
Laurent
