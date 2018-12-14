Received: from eggs.gnu.org ([2001:4830:134:3::10]:42168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gXpxP-00037Z-NB
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gXpxH-0001ys-Gb
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:04:51 -0500
Received: from mail-eopbgr790130.outbound.protection.outlook.com
	([40.107.79.130]:34026
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
	id 1gXpxH-0001xX-6F
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:04:47 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 14 Dec 2018 16:04:43 +0000
Message-ID: <20181214160437.GC4314@quinoa.localdomain>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-6-cota@braap.org>
	<20181214155724.GB4314@quinoa.localdomain>
In-Reply-To: <20181214155724.GB4314@quinoa.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8685FAFA3589434B8E387160EF9115FE@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 05/38] plugin: add user-facing API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On Dec 14 10:57, Aaron Lindsay wrote:
> One thing I'd like to see is support for unregistering callbacks once
> they are registered.

By the way, I'm willing to work on this if we agree it sounds reasonable
and fits in with the rest of your implementation.

-Aaron
