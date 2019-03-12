Received: from eggs.gnu.org ([209.51.188.92]:56461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3bRF-0002nf-28
	for qemu-devel@nongnu.org; Tue, 12 Mar 2019 03:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3bPp-00008B-7E
	for qemu-devel@nongnu.org; Tue, 12 Mar 2019 03:01:34 -0400
References: <20190311165538.6623-1-alex.bennee@linaro.org>
	<532e5c6d-b93e-7fb3-f987-22e9b0362acb@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fdbdeb73-032b-229b-c25b-aeb60770c38c@redhat.com>
Date: Tue, 12 Mar 2019 08:01:28 +0100
MIME-Version: 1.0
In-Reply-To: <532e5c6d-b93e-7fb3-f987-22e9b0362acb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/qemugdb: re-license timers.py to
 GPLv2 or later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 11/03/2019 18.55, Paolo Bonzini wrote:
> On 11/03/19 17:55, Alex Benn=C3=A9e wrote:
>> I'm the sole author (aside from a one line by Greg fixing encoding)
>> and I was asked nicely on IRC to bring it into line with the rest of
>> the files.
>>
>> Cc: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  scripts/qemugdb/timers.py | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
>> index 51ea04b5e2..f0e132d27a 100644
>> --- a/scripts/qemugdb/timers.py
>> +++ b/scripts/qemugdb/timers.py
>> @@ -6,8 +6,10 @@
>>  #
>>  # Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>  #
>> -# This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
>> -# the COPYING file in the top-level directory.
>> +# This work is licensed under the terms of the GNU GPL, version 2 or =
later.
>> +# See the COPYING file in the top-level directory.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> =20
>>  # 'qemu timers' -- display the current timerlists
>=20
> +qemu-trivial

Reviewed-by: Thomas Huth <thuth@redhat.com>

... I think Laurent just sent his trivial PULL request for soft-freeze
already ... I still plan to send another PULL request today, so if
nobody else wants to pick it up for soft-freeze today, I can add it to
my queue if you like.
